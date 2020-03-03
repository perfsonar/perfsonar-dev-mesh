#
# Makefile for Limit Config Updater
#

NAME := ps-dev-mesh
LIBEXEC := /usr/libexec/$(NAME)
OWNER := root

PROGRAM := update-limits
INSTALLED_PROGRAM := $(LIBEXEC)/$(PROGRAM)

default:
	@echo "Nothing to do."

$(LIBEXEC):
	mkdir -p "$@"

install: $(LIBEXEC)
	install -m 555 -o "$(OWNER)" -g "$(OWNER)" "$(PROGRAM)" "$(INSTALLED_PROGRAM)"
	crontab -l -u "$(OWNER)" 2>/dev/null \
	| fgrep -v "$(INSTALLED_PROGRAM)" \
	| (cat && echo "0 0 * * * $(INSTALLED_PROGRAM)") \
	| crontab -u "$(OWNER)" -
	-$(INSTALLED_PROGRAM)


uninstall:
	rm -rf $(LIBEXEC) /etc/pscheduler/limits.conf
	crontab -l -u "$(OWNER)" 2>/dev/null \
	| fgrep -v "$(INSTALLED_PROGRAM)" \
	| crontab -u "$(OWNER)" -

clean:
	rm -rf $(TO_CLEAN) *~
