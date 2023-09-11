# Environment Global
export PATH=/Applications/anaconda3/bin:$PATH

## Java settings
JAVA_8_HOME=$(/usr/libexec/java_home -v 1.8)
JAVA_11_HOME=$(/usr/libexec/java_home -v 11)
JAVA_17_HOME=$(/usr/libexec/java_home -v 17)
export JAVA_HOME=$JAVA_17_HOME
export PATH=$JAVA_HOME/bin:$PATH
export CLASS_PATH=$JAVA_HOME/lib

