# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/ptr_container
    REF boost-${VERSION}
    SHA512 fd45d221bc9dfb81822943c8bcfa02285f3054977bb07285c5754b8cef7c3db4ecb90e591410bc636e3474ae71ec2e232e5f2d3ea4a46caf14182633b1954213
    HEAD_REF master
)

set(FEATURE_OPTIONS "")
boost_configure_and_install(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS ${FEATURE_OPTIONS}
)
