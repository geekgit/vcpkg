include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO google/re2
    REF 1c7eb5604bc46c0198fc7bc35b32985ffe57ca93
    SHA512 5b6e2eea033f95104adf4d1e2fc799f436b332edccf8f8d4e025c3884299141cdd1f6f29e45f91baf50d37cd68536192bb07217f915ab4a33e2dc26968c8e89d
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS -DRE2_BUILD_TESTING=OFF
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/re2 RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
