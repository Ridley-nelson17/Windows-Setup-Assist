import ctypes, sys, os

def is_admin():
    try: return ctypes.windll.shell32.IsUserAnAdmin()
    except: return False

class SetupAssist:
	def __init__(self, args):
		self.EXEC_ARGS = args
		self.PATH = os.path.abspath(os.path.dirname(__file__))
		self.WSA_DIR = '"C:\\ProgramData\\Windows Setup Assist"'
		self.WSA_FALLBACK_DIR = os.path.join(os.path.expanduser('~'), os.getenv('LOCALAPPDATA'))



if not is_admin(): ctypes.windll.shell32.ShellExecuteW(None,"runas", sys.executable,__file__,None,1);sys.exit()

if __name__ == "__main__":
	SetupAssist(args=sys.argv)