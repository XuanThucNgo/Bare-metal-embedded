PRO_DIR				:= .
PATH_OUTPUT  	 = ../output
PROJ_NAME			:= gpio

INCLUDE_DIRS 	:= $(PRO_DIR)/include
INCLUDE_DIRS 	+= $(PRO_DIR)/../driver/gpio/include

SRC_DIRS			:= $(PRO_DIR)/source
SRC_DIRS			+= $(PRO_DIR)/../driver/gpio/source

SRC_FILES			:= $(foreach SRC_DIRS, $(SRC_DIRS), $(wildcard $(SRC_DIRS)/*))
INCLUDE_FILES	:= $(foreach INCLUDE_DIRS, $(INCLUDE_DIRS), $(wildcard $(INCLUDE_DIRS)/*))

COMPILER_DIR	:= C:/GCC_THUC
LINKER_FILE		:= $(PRO_DIR)/linker/stm32f1.ld

CC						:= $(COMPILER_DIR)/bin/arm-none-eabi-gcc
LD						:= $(COMPILER_DIR)/bin/arm-none-eabi-ld

INCLUDE_DIRS_OPT := $(foreach INCLUDE_DIRS, $(INCLUDE_DIRS), -I$(INCLUDE_DIRS))

CC_OPT				:= -mcpu=cortex-m3 -c -O0 -g -mfloat-abi=soft -std=gnu11 -mthumb $(INCLUDE_DIRS_OPT)
LD_OPT				:= -T $(LINKER_FILE) -Map $(PATH_OUTPUT)/$(PROJ_NAME).map

OBJ_FILES := $(notdir $(SRC_FILES))
OBJ_FILES := $(subst .c,.o, $(OBJ_FILES))
PATH_OBJS := $(foreach OBJ_FILES, $(OBJ_FILES), $(PATH_OUTPUT)/$(OBJ_FILES))

#search path .c and .h file
vpath %.c $(SRC_DIRS)
vpath %.o $(INCLUDE_DIRS)

build: $(OBJ_FILES) $(LINKER_FILE)
	$(LD) $(LD_OPT) $(PATH_OBJS) -o $(PATH_OUTPUT)/$(PROJ_NAME).elf
	$(COMPILER_DIR)/arm-none-eabi/bin/objcopy.exe -O ihex "$(PATH_OUTPUT)/$(PROJ_NAME).elf" "$(PATH_OUTPUT)/$(PROJ_NAME).hex"
	size $(PATH_OUTPUT)/$(PROJ_NAME).elf
	size $(PATH_OUTPUT)/$(PROJ_NAME).hex
	@echo "------------------- build OK ------------------"

%.o: %.c $(INCLUDE_FILES)
	mkdir -p $(PATH_OUTPUT)
	$(CC) $(CC_OPT) -c $< -o $(PATH_OUTPUT)/$@

run:
	$(PRO_DIR)/ST-LINK_Utility/ST-LINK_CLI.exe -p "$(PATH_OUTPUT)/$(PROJ_NAME).hex" 0x08000000
	$(PRO_DIR)/ST-LINK_Utility/ST-LINK_CLI.exe -rst	

.PHONY: clean
clean:
	rm -rf $(PATH_OUTPUT)	