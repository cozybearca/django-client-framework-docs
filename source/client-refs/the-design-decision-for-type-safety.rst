The design decision for API type-safety
=======================================

The goal of the client libraries is to provide type safety to gard against typos
that could be made on model properties, at the same type, utilize Django's
flexible QuerySet API. We would also like to keep a consistent API interface
across all supported programming languages, so that the learning curve can be
flat. Finally, we would like the client's model code to be automatically
generated according to the backend code.

There are some difficulties when designing such API. For instance, we can only
use features that are present in all supported programming languages. Advance
features such as the ``Partial<T>`` type in `TypeScript`, or `associated types`
in `Swift` cannot be used, because they don't exist in other languages, and the
API would be inconsistent.

We want to prevent typos made when querying and updating objects. The current
API provides limited guarantees. For instance, when modifying model properties
and call `ObjectManager.save()`_, typos are prevented because the programming
language only allows access on defined properties.

.. code-block:: ts

    let product: ObjectManager<Product> = ...
    product.barcode = "xxyy"
    product.save()


How can we make APIs such as `ObjectManager.update(...)`_ or
`CollectionManager.page(...)`_ type safe? There are two types of difficulties we
must take into consideration. First, you need to realize that the backend modal
API such as ``PATCH /product/1`` does not only accept valid properties that are
defined on the model. In fact, the backend could use `DelegatedSerializer`_ to
accept a variaty of key-value pairs. For instance, if a `User` model API is
designed to change user password, the backend will expect an request such as:

.. code-block:: JSON

    // PATCH /user/1

    {
        old_password: "1234",
        new_password: "xxyy",
    }

The backend can achieve this with the `DelegatedSerializer`_ class. However,
neither `old_password` and `new_password` are keys on the `User` model.

To resolve this issue, we can consider making the `ObjectManager.update(...)`_ a
generic method such as:

.. code-block:: TypeScript

    update<X>(data: X) {
        ...
    }

where X is any type that is serializable. This way we have define a separate interface such as

.. code-block:: TypeScript

    interface UserUpdatePassword {
        old_password: string
        new_password: string
    }

Then when calling the `ObjectManager.update(...)`_ method you can specify the ``X``:


.. code-block:: TypeScript

    .update<UserUpdatePassword>(data)

[to be continued]
