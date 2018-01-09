.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = python-proxmoxer
PACKAGE_VERSION       = 1.0.2
PACKAGE_SOURCE        = https://pypi.python.org/packages/a2/66/e42223312d24ba9c41b3865a92dacc89515607a952385134fe62284f6399/proxmoxer-$(PACKAGE_VERSION).tar.gz
PACKAGE_DISTRIBUTIONS = jessie stretch

package.checkout:
	$(call log,Checkout)

	mkdir $(call verbose, , ,--verbose) --parents $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl $(call verbose,--silent,--silent --show-error, ) --location $(PACKAGE_SOURCE) \
		| bsdtar $(call verbose, , ,-v) -xf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE) --strip-components=1

package.prepare:
	$(call log,Prepare)
	cp $(call verbose, , ,--verbose) --no-target-directory --recursive \
		$(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild --no-lintian -us -uc -b $(call verbose,>/dev/null 2>&1,>/dev/null, )
