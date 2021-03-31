Getting Starting with Client Libraries
======================================

.. seealso::

    This tutorial follows the previous tutorial "`Getting Starting with Django
    Backend`_". In this section, we assume the `Product` and `Brand` models are
    correctly set up.

Instead of sending HTTP requests manually to query the backend RESTful API,
Django Client Framework's client libraries support quering the backend in
frontend's native programming language, with a set of APIs that are similar to
Django's `QuerySet`.


Install client libraries
------------------------

TypeScript
~~~~~~~~~~

The TypeScript client can be installed with the npm or yarn package
managers.

.. tabs::

    .. code-tab:: bash NPM

        npm install django-client-framework

    .. code-tab:: bash Yarn

        yarn add django-client-framework


Swift
~~~~~


Kotlin
~~~~~~

Define a model class
--------------------

Since a `Product` model is defined at the Django backend, we need to define a
`Product` model that mirrors the backend in the frontend language.

.. warning::

    A more accurate statement is the `Product` model in the frontend mirrors the
    `ProductSerializer` in the backend. This is because a serializer can support
    fields that doesn't exist on the model, for instance, through
    `SerializerMethodField`.

Similar to the Django models, the `Product` model in the frontend should also
extend the `Model` base class.

.. tabs::

    .. code-tab:: ts

        import { Model, CollectionManager } from "django-client-framework"

        class Product extends Model {
            static readonly objects = new CollectionManager(Product)
            barcode: string = ""
        }




Retrieve a model instance
-------------------------

To retrieve a `Product` instance, we use the `CollectionManager` class. To
retrieve an instance of the `CollectionManager`, you can either create it
yourself, or access it through tbe `.objects` static member on the `Product`
class.

.. tabs::

    .. code-tab:: ts

        import { Ajax } from "django-client-framework"

        Ajax.url_prefix = "http://localhost:8000"

        let page = await Product.objects.page({})
        console.log(page)

        /*
            PageResult {
                page: 1,
                limit: 50,
                total: 1,
                previous: null,
                next: null,
                objects: [ Product { id: 1, barcode: 'xxyy' } ]
            }
        */


.. seealso::

    Besides retrieving object, the client libraries also support methods that
    modify and delete objects. See the full set of APIs here. [todo]
