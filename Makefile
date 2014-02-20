AUTOMATION_SOURCE_DIR=./
AUTOMATION_TEST_SOURCE_DIR=${AUTOMATION_SOURCE_DIR}
NODE_MODULES_DIR=node_modules/
BUILD_DIR=./test/build/

.PHONY: all test \
  	copy_vendor_libs \
		build prep \
		clean 

all: clean test

test: build
	for HTML_FILE in $(shell ls ${BUILD_DIR}html) ; do \
		${NODE_MODULES_DIR}.bin/mocha-phantomjs \
			${BUILD_DIR}html/$$HTML_FILE ; \
	\
	done

build: copy_vendor_libs
	@@${NODE_MODULES_DIR}.bin/coffee \
		${AUTOMATION_SOURCE_DIR}build.coffee \
		${CURDIR}/${BUILD_DIR}
	@@${NODE_MODULES_DIR}.bin/coffee --compile \
		--output ${BUILD_DIR}js/ \
		${AUTOMATION_TEST_SOURCE_DIR}

copy_vendor_libs: prep
	@@cp ${NODE_MODULES_DIR}mocha/mocha.css \
		${BUILD_DIR}js/vendor/
	@@cp ${NODE_MODULES_DIR}mocha/mocha.js \
		${BUILD_DIR}js/vendor/
	@@cp ${NODE_MODULES_DIR}chai/chai.js \
		${BUILD_DIR}js/vendor/
	@@cp ${NODE_MODULES_DIR}sinon/pkg/sinon-1.8.2.js \
		${BUILD_DIR}js/vendor/
	@@cp ${NODE_MODULES_DIR}sinon-chai/lib/sinon-chai.js \
		${BUILD_DIR}js/vendor/

prep:
	@@test -d ${BUILD_DIR} || mkdir ${BUILD_DIR}
	@@test -d ${BUILD_DIR}html/ || mkdir ${BUILD_DIR}html/
	@@test -d ${BUILD_DIR}js/ || mkdir ${BUILD_DIR}js/
	@@test -d ${BUILD_DIR}js/vendor/ || mkdir ${BUILD_DIR}js/vendor/ 

clean:
	@@rm -rf ${BUILD_DIR}

