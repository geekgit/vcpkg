include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Exiv2/exiv2
    REF bb2019149ae2b6f226e8d6be5f5828898b455a03
    SHA512 a71e53eeb7f1725fd12d34fa6990b4d7ef1da1c02be009808e4e75b49791d210f5c34d4b174f52f1a4f10c10358b611f57a65efe4012f5ae9c2c14dd57c79677
    HEAD_REF master
)

vcpkg_apply_patches(
    SOURCE_PATH "${SOURCE_PATH}"
    PATCHES "${CMAKE_CURRENT_LIST_DIR}/use-iconv.patch"
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH "share/exiv2/cmake")

vcpkg_copy_pdbs()

# Clean
file(GLOB EXE ${CURRENT_PACKAGES_DIR}/bin/*.exe ${CURRENT_PACKAGES_DIR}/debug/bin/*.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include ${CURRENT_PACKAGES_DIR}/debug/share ${EXE} ${DEBUG_EXE})

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

# Handle copyright 
file(COPY ${SOURCE_PATH}/ABOUT-NLS DESTINATION ${CURRENT_PACKAGES_DIR}/share/exiv2)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/exiv2/ABOUT-NLS ${CURRENT_PACKAGES_DIR}/share/exiv2/copyright)
