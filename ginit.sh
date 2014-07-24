touch README.md
cp ~/scripts/.gitignore .
git init
git add README.md .gitignore
git commit -m "First commit"
git remote add origin git@github.com:jam2079/$1.git
git push -u origin master
git remote rename origin $1

