
SRC_DIRS := src-rt src-rt-5.02hnd src-rt-6.x.4708 src-rt-7.x.main src-rt-7.14.114.x

rt-ac86u:
	make -C release/src-rt-5.02hnd $@

rt-ac56u:
	make -C release/src-rt-6.x.4708 $@

rt-ac68u:
	make -C release/src-rt-6.x.4708 $@

rt-ac87u:
	make -C release/src-rt-6.x.4708 $@

rt-ac3200:
	make -C release/src-rt-7.x.main/src $@

rt-ac3100:
	make -C release/src-rt-7.14.114.x/src $@

rt-ac88u:
	make -C release/src-rt-7.14.114.x/src $@

rt-ac5300:
	make -C release/src-rt-7.14.114.x/src $@

.PHONY:
$(SRC_DIRS):
	make -C release/$@ cleankernel clean || true
	rm -f release/$@/.config release/$@/image/*.trx release/$@/image/*.w

.PHONY:
clean: $(SRC_DIRS)
