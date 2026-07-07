#!/bin/sh

file="$1" w="${2:-$(tput cols)}" h="$3" x="$4" y="$5"

ext=$(echo "${file##*.}" | tr '[:upper:]' '[:lower:]')

case "$ext" in
    json|jsonl) jq -C -r . "${file}" ;;
    pdf) pdftotext -layout -nopgbrk -nodiag "${file}" - ;;
    md) CLICOLOR_FORCE=1 glow --style dark "${file}" --width ${w} ;;
    zip) unzip -l "${file}" ;;
    gz|tgz) tar -tzf "${file}" ;;
    *) bat --color=always --style=numbers --terminal-width="${w}" --wrap=auto "${file}" 2>/dev/null || cat "${file}" ;;
esac

