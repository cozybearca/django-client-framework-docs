Model
=====

Similar to the `Model` class in Django, `Model` is the base class of all user
defined models in the frontend. The implementation varies between the frontend
languages, but generally, the `Model` base class enforces the existance of an
read-only `id` field. In addition, a `Model` subclass can be
serialized/deserialized from/to an JSON representation.


.. tabs::

    .. code-tab:: ts

        Model

ObjectManager
=============

