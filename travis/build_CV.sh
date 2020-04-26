#!/bin/bash -x

wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;
bash miniconda.sh -b -p $HOME/miniconda
export PATH="$HOME/miniconda/bin:$PATH"
hash -r
conda config --set always_yes yes --set changeps1 no
conda update -q conda
conda info -a
conda create --yes -n paper
source activate paper
conda install -c conda-forge -c pkgw-forge tectonic

# Clone the code
FILE=CV # if there's already a CV folder
if [ -d "$FILE" ]
then
    rm -r CV
fi
git clone https://git.overleaf.com/5ea536deb615250001c1ad20
mv 5ea536deb615250001c1ad20 CV

# Build the paper using tectonic
cd CV
tectonic main.tex --print
mv main.pdf CV_Savel.pdf
