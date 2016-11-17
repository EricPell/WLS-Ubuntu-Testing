#!/usb/bin/python
class Hello:
    # static attribute string "msg1"
    msg1 = "Hello World - If you can read me I am functioning"
    def echo(self):
        print(self.msg1)

print("Hello's msg1: {0}".format(Hello.msg1))
h = Hello()
h.echo()
print(h)
