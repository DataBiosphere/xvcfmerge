from setuptools import setup, find_packages

setup(
    name='gs_download_for_test',
    version='0.0.1',
    description='miniwdl download plugin for gs://',
    author='Brian Hannafious',
    py_modules=["inject_credentials"],
    python_requires='>=3.6',
    setup_requires=[],
    install_requires=[""],
    reentry_register=True,
    entry_points={
        'miniwdl.plugin.task': ['inject_credentials = inject_credentials:main'],
    }
)
