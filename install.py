import ctypes, sys, os

INSTALL_PATH="C:/ProgramData/Windows Setup Assist"

def is_admin():
    try: return ctypes.windll.shell32.IsUserAnAdmin()
    except: return False

class Restore:
	def __init__(self, args):
		pass


if not is_admin(): ctypes.windll.shell32.ShellExecuteW(None,"runas", sys.executable,__file__,None,1);sys.exit()
try:
	if os.path.exists(INSTALL_PATH): print("yes")
	else: os.mkdir(INSTALL_PATH)
except Exception as e:
	print(e)