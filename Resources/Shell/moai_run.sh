echo "EXECUTE MOAI"
source ~/.bash_profile
moai_file_dir=$( dirname "$1" )
cd $moai_file_dir
$MOAI_HOME/bin/moai "$@"
echo "SCRIPT END"
