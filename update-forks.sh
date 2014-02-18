#update forked repos
export CURR_DIR=`readlink -f .`
export PARENT_DIR=`readlink -f ..`
echo updating forked repos...
cd $PARENT_DIR
cd $PARENT_DIR/android
git fetch cm
cd $PARENT_DIR/build
git fetch cm
git merge cm/cm-10.2
cd $PARENT_DIR/frameworks/base
git fetch cm
git merge cm/cm-10.2
cd $PARENT_DIR/frameworks/native
git fetch cm
git merge cm/cm-10.2
cd $PARENT_DIR/frameworks/opt/telephony
git fetch cm
git merge cm/cm-10.2
cd $PARENT_DIR/hardware/libhardware
git fetch cm
git merge cm/cm-10.2
cd $PARENT_DIR/hardware/libhardware_legacy
git fetch cm
git merge cm/cm-10.2
cd $PARENT_DIR/packages/apps/Phone
git fetch cm
git merge cm/cm-10.2
cd $PARENT_DIR/vendor/cm
git fetch cm
git merge cm/cm-10.2
cd $PARENT_DIR
echo Update complete....
