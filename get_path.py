import sys

def main():
    if len(sys.argv)>1:
        target_path=sys.argv[1]
        print(target_path[0:target_path.rfind('/')])

if __name__=='__main__':
    main()
