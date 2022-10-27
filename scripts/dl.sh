#!/bin/bash

echo ::group::Download weekly leaflet

YEAR=${1:-$(date +%Y)}
WEEK=${2:-$(date +%U)} # or %V

echo "YEAR: ${YEAR}"
echo "WEEK: ${WEEK}"

pdf_url=$(curl -s "https://endpoints.leaflets.schwarz/v3/PL_pl_KDZ_8362_PL${WEEK}-LFT/flyer.json?regionCode=8362" | jq -r '.flyer.hiResPdfUrl')
echo "Downloading ${pdf_url}"
wget -c --progress=dot:mega "${pdf_url}" -O pdf/Kaufland-${YEAR}-${WEEK}.pdf


[ -z "${INPUT_GITHUB_TOKEN}" ] && {
    echo 'Missing input "github_token: ${{ secrets.GITHUB_TOKEN }}".';
    exit 1;
};

git remote -v

# get author
author_name="$(git show --format=%an -s)"
author_email="$(git show --format=%ae -s)"

# outputs
echo "::set-output name=name::"$author_name""
echo "::set-output name=email::"$author_email""

# git config
echo ::group::Set commiter
echo "git config user.name \"$author_name\""
git config user.name "$author_name"
echo "git config user.email $author_email"
git config user.email $author_email
echo ::endgroup::

# commit and push
echo ::group::Push
echo "git add ."
git add .
echo 'git commit --allow-empty -m "$YEAR/$WEEK"'
git commit --allow-empty -m "$YEAR/$WEEK"
echo "git push origin HEAD"
git push origin HEAD
echo ::endgroup::
