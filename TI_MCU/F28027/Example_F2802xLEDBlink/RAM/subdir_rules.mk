################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
%.obj: ../%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: C2000 Compiler'
	"D:/Softwares/TI/ccs/tools/compiler/ti-cgt-c2000_20.2.5.LTS/bin/cl2000" -v28 -ml -mt --include_path="D:/Softwares/TI/ccs/tools/compiler/ti-cgt-c2000_20.2.5.LTS/include" --include_path="D:/Softwares/TI/C2000Ware_3_04_00_00_Software/device_support/f2802x/common/include" --include_path="D:/Softwares/TI/C2000Ware_3_04_00_00_Software/device_support/f2802x/headers/include" --include_path="D:/Softwares/TI/C2000Ware_3_04_00_00_Software/device_support/f2802x" --include_path="D:/Softwares/TI/C2000Ware_3_04_00_00_Software/libraries/math/IQmath/c28/include" --define=_DEBUG --define=LARGE_MODEL -g --diag_suppress=10063 --diag_warning=225 --verbose_diagnostics --quiet --preproc_with_compile --preproc_dependency="$(basename $(<F)).d_raw" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

