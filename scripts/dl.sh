#!/bin/bash

YEAR=${1:-$(date +%Y)}
WEEK=${2:-$(date +%U)} # or %V

echo "YEAR: ${YEAR}"
echo "WEEK: ${WEEK}"

echo ::group::Download weekly leaflet

mkdir -p pdf

pdf_url=$(curl -s "https://endpoints.leaflets.schwarz/v3/PL_pl_KDZ_8362_PL${WEEK}-LFT/flyer.json?regionCode=8362" | jq -r '.flyer.hiResPdfUrl')
echo "Downloading ${pdf_url}"
wget --progress=dot:mega "${pdf_url}" -O pdf/Kaufland-${YEAR}-${WEEK}.pdf


[ -z "${INPUT_GITHUB_TOKEN}" ] && {
    echo 'Missing input "github_token: ${{ secrets.GITHUB_TOKEN }}".';
    echo ::endgroup::
    exit 1;
};
echo ::endgroup::
