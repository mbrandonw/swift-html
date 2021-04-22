bootstrap: carthage xcodeproj

carthage:
	carthage update --no-build --use-submodules

xcodeproj:
	PF_DEVELOP=1 swift run xcodegen

test-linux:
	docker run \
		--rm \
		-v "$(PWD):$(PWD)" \
		-w "$(PWD)" \
		swift:5.1 \
		bash -c 'make test-swift'

test-macos: xcodeproj
	set -o pipefail && \
	xcodebuild test \
		-scheme Html_macOS \
		-destination platform="macOS" \
		| xcpretty

test-ios: xcodeproj
	set -o pipefail && \
	xcodebuild test \
		-scheme Html_iOS \
		-destination platform="iOS Simulator,name=iPhone 11 Pro Max,OS=13.2.2" \
		| xcpretty

test-swift:
	swift test \
		--parallel \
		--enable-test-discovery

test-all: test-linux test-macos test-ios test-swift
