
Modify this documentation
#########################

This documentation is made
with Sphinx. The syntax used to compose this documentation is called
reStructuredText (RST). For a convenient documentation visit
https://sphinx-tutorial.readthedocs.io/step-1/.

THe doc requires some dependencies to compile. If you have docker, it is much
easier.

With docker, you can launch a local server by running:

.. code-block:: bash

    docker-compose build
    docker-compose up server

Then visit ``http://localhost:12800`` for the documentation.

To compile the documentation, run:

.. code-block:: bash

    docker-compose run make html
