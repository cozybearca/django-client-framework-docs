.. _Permission-Concepts-and-Management:

Permission Concepts and Management
==================================

Django Client Framework supports four levels of permissions: `model`, `object`,
`model field`, and `object field`. There are four types of permissions: `read`,
`write`, `create`, `delete`. The framework also supports `user` and `group`. A
user can be added to multiple groups. A permission can be given to a `user` or a
`group`. All users in a group obtain the permissions that are assigned to the
group. By default, all users and groups have no permissions assigned.

The framework uses a deterministic permission model. This means instead of
assigning user permissions dynamically as your web service runs, the permissions
are determined during django data migrations. You must design the permission
structure depending on the user and object relations.


Types of permissions
--------------------

There are four types of permissions: `read`, `write`, `create`, `delete`. These
permissions are checked when users access the RESTful API. In particular, when
accessing the model collection, the model object, and the related object APIs,
the permissions allow for the following HTTP methods:

    :read: ``GET``
    :write: ``PATCH``
    :create: ``POST`` and ``PUT``
    :delete: ``DELETE``


Levels of permissions
-----------------------

There are four levels of permissions: `model`, `object`, `model field`, and
`object field`. In terms of inclusion, ``model > object > model field > object
field``.

    Model permission
        When assigning permissions to a model, the permissions apply to all
        objects of the model class. For instance, you can assign the read
        permission for the ``Product`` class to the ``anyone`` group so that all
        products are readable to any user.

    Object permission
        When assigning permissions to an object, the permissions only affects
        the object but not the others. For instance, you can assign the write
        permission for a `User` object to itself, so that any user can modify
        their own personal data.

    Model field permission
        Instead of assigning permissions to a model, in which case the
        permissions apply to all fields on the model, you can also allow the
        permission on a particular field of the model. For instance, you may
        want to give user the read-only permission on a model, except for a
        particular field, which can be both read and written.

    Object field permission
        Similar to model field permission except the permission is assgined to
        one object instead of all.


Default users
-------------

The framework comes with a default user named `AnonymousUser`. This is a dummy
user object that's used to assign permissions to any anonymous user. The user
can be accessed by ``django_client_framework.permissions.default_users.anonymous``.

.. note::
    Since in most applications, the permissions for the anonymous user are most
    likely a subset of any other user, you should consider assigning the
    permissions to the ``default_groups.anyone`` group instead.

You can add custom default users that are required by your application using the
``@register_default_user`` decorator.


Default groups
--------------

The framework comes with a default group named `anyone`. This is a dummy group
object that includes all users, including the `anonymous` user. The user can be
accessed by ``django_client_framework.permissions.default_groups.anyone``.

You can also add custom default groups that are required by your application
using the ``@register_default_group`` decorator.


Example
    .. code-block:: py

        from .models import Product, User
        from django_client_framework.permissions import default_groups

        add_perms_shortcut(default_groups.anyone, Product, "r")

        user = m.User.objects.create(username="example_user")
        add_perms_shortcut(user, user, "r")
        add_perms_shortcut(user, user, "rw", "first_name")
