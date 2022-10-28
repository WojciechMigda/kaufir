#!/bin/bash

YEAR=${1:-$(date +%Y)}
WEEK=${2:-$(date +%U)} # or %V

echo "YEAR: ${YEAR}"
echo "WEEK: ${WEEK}"

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
