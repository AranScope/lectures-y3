# find ./ -iname "*.md" -type f -exec sh -c 'pandoc --template /home/aran/work/uni/lectures-y3/template.tex "${0}" -o "./$(dirname "{}")/pdf/$(basename "${0%.md}.pdf")"' {} \;
# pandoc --template /home/aran/work/uni/lectures-y3/template.tex *.md -o pdf/notes.pdf

# find all directories that contain markdown files
find . -maxdepth 1 -type d -not -path '*/\.*' -not -path '.' -exec sh -c 'pandoc --template ./template.tex "{}"/*.md -o "{}"/pdf/"{}".pdf' \;

# --number-sections 