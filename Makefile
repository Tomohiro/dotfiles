# vim:set ft=make:

# Define build tools.
LN = ln -sf
RM = rm -f

# Define constants.
KERNEL      = $(shell uname)
DEVELOPMENT = $(HOME)/Dropbox/Development
DOTFILES    = $(DEVELOPMENT)/dotfiles
INSTALLTO   = $(HOME)
IGNORES     = bin bundle Makefile README.markdown Darwin Linux Windows


.PHONY: help install bundle-show bundle-update

help:
	@echo "Please type: make [target]"
	@echo "  install         Install dotfiles to $(INSTALLTO)"
	@echo "  bundle-show     Show git submodules"
	@echo "  bundle-update   Update git submodules"
	@echo "  help            Show this help messages"


install:
	@echo "Install dotfiles Start"
	$(LN) $(DEVELOPMENT) $(INSTALLTO)/
	$(LN) $(DOTFILES)/bin $(INSTALLTO)/
	@for file in `ls $(DOTFILES)`; do\
		for ignore in $(IGNORES); do\
			if [ $$ignore = $$file ]; then\
				continue 3;\
			fi;\
		done;\
		$(RM) $(INSTALLTO)/.$$file;\
		echo " [linkup] $(INSTALLTO)/.$$file";\
		$(LN) $(DOTFILES)/$$file $(INSTALLTO)/.$$file;\
	done;\
	for file in `ls $(DOTFILES)/$(KERNEL)`; do\
		$(RM) $(INSTALLTO)/.$$file;\
		echo " [linkup] $(INSTALLTO)/.$$file";\
		$(LN) $(DOTFILES)/$(KERNEL)/$$file $(INSTALLTO)/.$$file;\
	done
	@echo "Finished."


bundle-show:
	@echo "Show git submodules."
	@git submodule status


bundle-update:
	@echo "Update git submodules."
	@git submodule foreach 'git pull origin master'
