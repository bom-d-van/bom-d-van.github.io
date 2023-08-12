#!/usr/bin/env bash

echo '<!doctype html>'
echo '<html lang="en">'
echo '<head>'
echo '    <meta charset="utf-8">'
echo '    <meta name="date" content="$date-meta$">'
echo '    <title>resume</title>'
echo '</head>'
echo '<body>'

cat resume-cn-merged.html
echo '    <p style="page-break-before:always;"></p>'
cat resume-en-merged.html

echo '</body>'
echo '</html>'
