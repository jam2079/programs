git push -u $1 master `pwd | rev | cut -d"/" -f1 | rev`
