# As new architectures are supported with newer CUDA versions, this list should
# probably be updated. At the moment we fallback to compiling for all currently
# known architectures, but that won't handle new ones. See here for reference:
# https://github.com/conda-forge/torchvision-feedstock/blob/master/recipe/build-torch.sh
if [[ "$cuda_compiler_version" == "None" ]]; then
  export FORCE_CUDA=0
else
  if [[ ${cuda_compiler_version} == 11.2* ]]; then
      export TORCH_CUDA_ARCH_LIST="3.5;5.0;6.0;6.1;7.0;7.5;8.0;8.6+PTX"
  elif [[ ${cuda_compiler_version} == 11.8* ]]; then
      export TORCH_CUDA_ARCH_LIST="3.5;5.0;6.0;6.1;7.0;7.5;8.0;8.6;8.9+PTX"
  elif [[ ${cuda_compiler_version} == 12.* ]]; then
      export TORCH_CUDA_ARCH_LIST="5.0;6.0;6.1;7.0;7.5;8.0;8.6;8.9;9.0+PTX"
  else
        echo "unsupported cuda version. edit build.sh"
        exit 1
  fi
  export FORCE_CUDA=1
fi

echo "ENVIRONMENT VARIABLE VALUES ARE:"
env

echo "COMPILER VERSIONS ARE:"
nvcc --version
$GCC --version

echo "BUILDING PYTHON PACKAGE:"
${PYTHON} -m pip install . -vv
