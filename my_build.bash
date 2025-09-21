set -ue

if mamba info | grep --quiet --ignore-case --extended-regexp 'active\s+environment\s*:\s*none' ; then
	printf "pandas-dev mamba env is not active\n"
	exit 1
fi

COMMAND=
OK=0
if [ $# -gt 0 ]; then
	case "$1" in
		"pandas" | "docs" | "docs_clean" | "test" | "test_trace")
			COMMAND=$1
			OK=1
			;;
	esac
fi

if [ $OK -eq 0 ]; then
	printf 'usage: %s { pandas | docs | docs_clean | test | test_trace } args...\n' "$0"
	exit 2
fi

shift

SDK_PATH=$(xcrun --show-sdk-path)

export CFLAGS="-isysroot $SDK_PATH"
export LDFLAGS="-Wl,-syslibroot,$SDK_PATH"

case $COMMAND in
	pandas)
		#python setup.py build_ext --inplace -j8
		python -m pip install -ve . --no-build-isolation --config-settings editable-verbose=yes
		;;
	docs)
		pushd doc
		python make.py --num-jobs=1 html
		popd
		;;
	docs_clean)
		pushd doc
		python make.py clean
		popd
		;;
	test)
		python -m pytest --exitfirst $@
		;;
	test_trace)
		python -m trace --trace --module pytest --exitfirst $@
		;;
esac
