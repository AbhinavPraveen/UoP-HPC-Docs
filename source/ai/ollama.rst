.. include:: ../siteinclude.rst

Ollama
======

The Ollama free and open-source software for easily getting up and running with AI models can be used through containerisation with Podman (see :doc:`/containerisation/podman`). An example of using the software to run a model is given below.

Using Ollama to run `Meta's Llama 4 Scout <https://www.llama.com/models/llama-4/>`_ Model On an NVIDIA H100 GPU
---------------------------------------------------------------------------------------------------------------

To run the Llama 4 Scout model on an NVIDIA H100 GPU on the Lovelace cluster simply start an interactive GPU session (see :doc:`/user-guide/resources`), create a folder for Ollama, start an Ollama instance in this session, and then execute commands with the session.

.. code-block:: bash

   # Acquire a GPU session
   # This is subject to demand and availability of H100 GPUs
   # It may be worth running on a different resources
   srun --pty -p gpu_h100 --gpus 1 bash

   # Create a folder for ollama
   mkdir -p "$HOME/.ollama"

   # Start an Ollama instance
   podman run -d -v "$HOME/.ollama:/root/.ollama" --name ollama --device nvidia.com/gpu=all ollama/ollama

   # Run the model with the Ollama instance
   podman exec -it ollama ollama run llama4:scout

Once done, bring down your Ollama instance and exit your GPU session.

.. code-block:: bash

   podman kill ollama
   podman rm ollama
   exit
