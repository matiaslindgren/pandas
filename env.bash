eval "$($HOME/miniforge3/bin/mamba shell hook --shell bash)"
if [ ! -d $HOME/miniforge3/envs/pandas-dev ]; then
	mamba env create --file environment.yml
fi
mamba activate pandas-dev
