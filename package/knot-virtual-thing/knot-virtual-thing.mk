################################################################################
#
# knot-virtual-thing
#
################################################################################

KNOT_VIRTUAL_THING_VERSION = 9a7d4bdb197ef48caf33894bbea660f50f562717
KNOT_VIRTUAL_THING_SITE = git@github.com:alla3/knot-virtual-thing.git
KNOT_VIRTUAL_THING_SITE_METHOD = git
KNOT_VIRTUAL_THING_INSTALL_STAGING = NO
KNOT_VIRTUAL_THING_INSTALL_TARGET = YES
KNOT_VIRTUAL_THING_DEPENDENCIES = libell json-c rabbitmq-c knot-protocol-lib \
				libmodbus
KNOT_VIRTUAL_THING_AUTORECONF = YES
KNOT_VIRTUAL_THING_CONF_OPTS = --prefix=/usr/local --exec-prefix=/usr/local \
			       --sysconfdir=/etc

ifeq ($(BR2_ENABLE_DEBUG),y)
KKNOT_VIRTUAL_THING_CONF_OPTS += \
	--enable-debug --disable-optimization
else
KNOT_VIRTUAL_THING_CONF_OPTS += \
	--disable-debug --enable-optimization
endif

define KNOT_VIRTUAL_THING_BOOTSTRAP
	cd $(@D) && ./bootstrap
endef

KNOT_VIRTUAL_THING_POST_PATCH_HOOKS += KNOT_VIRTUAL_THING_BOOTSTRAP

define KNOT_VIRTUAL_THING_INSTALL_INIT_SCRIPT
	$(INSTALL) -D -m 0755 $(KNOT_VIRTUAL_THING_PKGDIR)/S65kthingd-daemon \
		$(TARGET_DIR)/etc/init.d/
endef

KNOT_VIRTUAL_THING_POST_INSTALL_TARGET_HOOKS += \
	KNOT_VIRTUAL_THING_INSTALL_INIT_SCRIPT

$(eval $(autotools-package))
