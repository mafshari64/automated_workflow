cd ./picongpu

module load git

git status
git fetch brian
git checkout dev
git branch -D pr5007
git checkout -b pr5007 brian/topic-addIonizerSupport
git status

cd ..
