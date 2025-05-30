vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO AravisProject/aravis
    REF "${VERSION}"
    SHA512 3a71228fdd3d2fc6926b4efc99f268130ad4c460a8d8573d7cfa9bc0833355e88e5fc8900302eb8b891a1cc1a7f4b8753a295e5fe10d9653b32258ab62ed2113
    HEAD_REF main
)

set(OPTIONS "")
set(OPTIONS_RELEASE "")
if("usb" IN_LIST FEATURES)
    list(APPEND OPTIONS -Dusb=enabled)
else()
    list(APPEND OPTIONS -Dusb=disabled)
endif()
if("packet-socket" IN_LIST FEATURES)
    list(APPEND OPTIONS -Dpacket-socket=enabled)
else()
    list(APPEND OPTIONS -Dpacket-socket=disabled)
endif()
if("fast-heartbeat" IN_LIST FEATURES)
    list(APPEND OPTIONS -Dfast-heartbeat=true)
else()
    list(APPEND OPTIONS -Dfast-heartbeat=false)
endif()
if("introspection" IN_LIST FEATURES)
    list(APPEND OPTIONS_RELEASE -Dintrospection=enabled)
    vcpkg_get_gobject_introspection_programs(PYTHON3 GIR_COMPILER GIR_SCANNER)
else()
    list(APPEND OPTIONS_RELEASE -Dintrospection=disabled)
endif()

vcpkg_configure_meson(
    SOURCE_PATH
        "${SOURCE_PATH}"
    OPTIONS
        ${OPTIONS}
        -Dviewer=disabled
        -Dgst-plugin=disabled
    OPTIONS_RELEASE
        ${OPTIONS_RELEASE}
    OPTIONS_DEBUG
        -Dintrospection=disabled
    ADDITIONAL_BINARIES
        "glib-mkenums='${CURRENT_HOST_INSTALLED_DIR}/tools/glib/glib-mkenums'"
        "glib-compile-resources='${CURRENT_HOST_INSTALLED_DIR}/tools/glib/glib-compile-resources${VCPKG_HOST_EXECUTABLE_SUFFIX}'"
        "g-ir-compiler='${GIR_COMPILER}'"
        "g-ir-scanner='${GIR_SCANNER}'"
)
vcpkg_install_meson(ADD_BIN_TO_PATH)

vcpkg_copy_pdbs()

vcpkg_fixup_pkgconfig()

vcpkg_copy_tools(
    AUTO_CLEAN
    TOOL_NAMES
        arv-camera-test-0.8
        arv-fake-gv-camera-0.8
        arv-test-0.8
        arv-tool-0.8
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
