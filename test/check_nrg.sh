#!/bin/sh
#$Id: check_nrg.sh.in,v 1.17 2007/12/28 02:11:01 rocky Exp $

if test "X" != "X" ; then
  vcd_opt='--no-vcd'
fi

if test "X$srcdir" = "X" ; then
  srcdir=`pwd`
fi

if test "X$top_srcdir" = "X" ; then
  top_srcdir=`pwd`/..
fi

if test "X$top_builddir" = "X" ; then
  top_builddir=`pwd`/..
fi

. ${top_builddir}/test/check_common_fn

if test ! -x $top_srcdir/src/cd-info ; then
  exit 77
fi

BASE=`basename $0 .sh`
test_name=videocd
opts="--quiet --no-device-info --nrg-file ${srcdir}/data/${test_name}.nrg $vcd_opt --iso9660"
test_cdinfo "$opts" ${test_name}.dump ${srcdir}/${test_name}.right
RC=$?
check_result $RC 'cd-info NRG test 1' "${CD_INFO} $opts"

BASE=`basename $0 .sh`
nrg_file=${srcdir}/data/monvoisin.nrg

if test -f  $nrg_file ; then
  test_cdinfo "-q --no-device-info --nrg-file $nrg_file $vcd_opt --iso9660 " \
    monvoisin.dump ${srcdir}/monvoisin.right
  RC=$?
  check_result $RC 'cd-info NRG test 2'
else 
  echo "-- Don't see NRG file ${nrg_file}. Test skipped."
  exit 0
fi

test_name='svcdgs'
nrg_file=${srcdir}/data/${test_name}.nrg
opts="-q --no-device-info --nrg-file $nrg_file $vcd_opt --iso9660"
if test -f  $nrg_file ; then
  test_cdinfo "$opts" ${test_name}.dump ${srcdir}/${test_name}.right
  RC=$?
  check_result $RC "cd-info NRG $test_name" "${CD_INFO} $opts"
else 
  echo "-- Don't see NRG file ${nrg_file}. Test skipped."
  exit $SKIP_TEST_EXITCODE
fi

test_name='cdda-mcn'
nrg_file=${srcdir}/data/${test_name}.nrg
opts="-q --no-device-info --nrg-file $nrg_file --no-cddb"
if test -f  $nrg_file ; then
  test_cdinfo "$opts" ${test_name}.dump ${srcdir}/${test_name}.right
  RC=$?
  check_result $RC "cd-info NRG $test_name" "${CD_INFO} $opts"
  exit $RC
else 
  echo "-- Don't see NRG file ${nrg_file}. Test skipped."
  exit $SKIP_TEST_EXITCODE
fi

#;;; Local Variables: ***
#;;; mode:shell-script ***
#;;; eval: (sh-set-shell "bash") ***
#;;; End: ***
