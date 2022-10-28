#!/bin/bash

YEAR=${1:-$(date +%Y)}
WEEK=${2:-$(date +%U)} # or %V

echo "YEAR: ${YEAR}"
echo "WEEK: ${WEEK}"

mkdir -p text

base=Kaufland-${YEAR}-${WEEK}
pdftotext -layout -nopgbrk pdf/${base}.pdf text/${base}.txt
