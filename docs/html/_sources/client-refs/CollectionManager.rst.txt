.. _dcf-collectionmanager:

CollectionManager<T: `Model`_>
==============================

A generic class where ``T`` is constrained by `Model`_. This class provides the
access to backend objects. You should use this class to retrieve an
``ObjectManager`` for an model object, instead of creating an ``ObjectManager``
directly.

Consturctor
-----------

Implementation varies. For TypeScript and Kotlin, you need to pass the
constructor of ``T`` in to the constructor, because the type information is
erased during the runtime.

.. warning::

    It is recommended to define a static member named ``objects`` on the model
    class, so that you can retrieve the ``CollectionManager`` instance directly.

    .. tabs::

        .. code-tab:: ts

            class Product extends Model {
                static readonly objects = new CollectionManager(Product)
            }

            let results = await Product.objects.page({})


Methods
-------

.. _CollectionManager.page(...):

.page(query, pagination)
^^^^^^^^^^^^^^^^^^^^^^^^

    query
        A dictionary of query parameters that eventually get encoded as the query
        parts of the URL. The key names are agnostic to :django:`Django's QuerySet
        API <models/querysets>`. Keys such as ``id__in`` (with an array of ids as
        the value) are supported. See :django:`Django's Field lookups
        <models/querysets/#field-lookups>`. Any value of the list/array type will
        have ``[]`` appended after the key name.

        For example, a query dictionary of (in JSON format)

        .. code-block:: JSON

            {
                "id__in": [1,2],
                "barcode": "xxyy",
                "price__gt": 12.00
            }

        will be encoded as
        ``?id__in[]=1&id__in[]=2&barcode=xxyy&price__gt=12.00``

        Suppoted keys
            Any property name of the model, or any :django:`Django's Field
            lookup keys <models/querysets/#field-lookups>`.

        Suppoted values
            Values of array, list, numbers, strings, empty, null types.

    pagination
        A dictionary indicating the number of pages, current page, and how to
        sort the result. Any value of the list/array type will have ``_``
        prepended before the key name, as a way to differentiate from the model
        property names.

        For example, a query dictionary of (in JSON format)

        .. code-block:: JSON

            {
                "limit": 50,
                "page": 1,
                "order_by": "-id"
            }

        will be encoded as ``?_limit=50&_page=1&_order_by=-id``.

        Suppoted key values
            :limit: number - how many items per page
            :page: number - which page to show
            :order_by: This is agnostic to Django's :django:`.order_by() <models/querysets/#order-by>` QuerySet API.
                Adding ``-`` before the key name sorts the property in the
                reverse order. Use ``,`` to join multiple keys.


    Returns
        A ``PageResult`` that contains the objects.



.. _CollectionManager.get(...):



.get(query)
^^^^^^^^^^^

    This method does the same thing as :ref:`CollectionManager.page(...)` except
    that it expects exactly one object to be returned from the server.

    Returns
        An :ref:`ObjectManager` object wrapping the model.
