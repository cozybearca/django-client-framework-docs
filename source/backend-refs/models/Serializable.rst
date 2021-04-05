Serializable
============

.. code-block:: py

    from django_client_framework.models import Serializable

This abstract model class provides caches for serialization.

.. note::

    Any :ref:`Model` to be registered as an API must inherit this class.


Inheritance
-----------

Subclasses of `Serializable`_ must override ``.serializer_class(cls)`` which
returns a `Serializer`_ class.


.. _Serializable.serializer_class():

.serializer_class(cls)
----------------------
    `required`, `classmethod`

    Returns
        The `Serializer`_ class for the model.


.. _Serializable.serializer:

.serializer
-----------

    Property
        An instance of the `Serializer`_ class returned by
        `Serializable.serializer_class()`_.


.. _Serializable.get_serialization_cache_timeout():

.get_serialization_cache_timeout()
----------------------------------

    Returns
        How long to cache the seriali
