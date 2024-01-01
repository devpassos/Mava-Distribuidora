import xml.dom.minidom
    
if __name__=="__main__":
    x = xml.dom.minidom.parse('NFE1.xml')
    nos = x.documentElement
    print("--> %s" % nos.nodeName)
    filhos1 = [no for no in nos.childNodes if no.nodeType == \
                x.ELEMENT_NODE]
    for pai in filhos1:
        print("----> %s" % pai.nodeName)
        filhos2 = [no for no in pai.childNodes if no.nodeType == \
                    x.ELEMENT_NODE]
        for filho in filhos2:
            print ("------> %s" % filho.nodeName)
            print ("------> %s" % filho.getAttribute('atributo1'))
            print ("------> %s" % filho.getAttribute('atributo2'))