echo "Hello AS" $MOAI_HOME
source ~/.bash_profile
echo "Hello AS 2" $MOAI_HOME
echo "$@"
base=$(dirname "$1")
echo 'base: ' $base
cd $base
pwd
$MOAI_HOME/bin/moai "$@"