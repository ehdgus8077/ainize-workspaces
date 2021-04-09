import os

c = get_config()

c.NotebookApp.quit_button = False
c.NotebookApp.open_browser = False
c.NotebookApp.allow_root = True
# https://forums.fast.ai/t/jupyter-notebook-enhancements-tips-and-tricks/17064/22
c.NotebookApp.iopub_msg_rate_limit = 100000000
c.NotebookApp.iopub_data_rate_limit = 2147483647
c.NotebookApp.port_retries = 0
c.NotebookApp.allow_remote_access = True
c.NotebookApp.disable_check_xsrf = True
c.NotebookApp.allow_origin = "*"
c.NotebookApp.trust_xheaders = True
c.MappingKernelManager.buffer_offline_messages = True
c.Application.log_level = "WARN"
c.NotebookApp.log_level = "WARN"
c.JupyterApp.answer_yes = True

# Do not delete files to trash: https://github.com/jupyter/notebook/issues/3130
c.FileContentsManager.delete_to_trash = False

shutdown_inactive_kernels = os.getenv("SHUTDOWN_INACTIVE_KERNELS", "false")
if shutdown_inactive_kernels and shutdown_inactive_kernels.lower().strip() != "false":
    cull_timeout = 172800  # default is 48 hours
    try:
        # see if env variable is set as timout integer
        cull_timeout = int(shutdown_inactive_kernels)
    except ValueError:
        pass

    if cull_timeout > 0:
        print(
            "Activating automatic kernel shutdown after "
            + str(cull_timeout)
            + "s of inactivity."
        )
        # Timeout (in seconds) after which a kernel is considered idle and ready to be shutdown.
        c.MappingKernelManager.cull_idle_timeout = cull_timeout
        # Do not shutdown if kernel is busy (e.g on long-running kernel cells)
        c.MappingKernelManager.cull_busy = False
        # Do not shutdown kernels that are connected via browser, activate?
        c.MappingKernelManager.cull_connected = False