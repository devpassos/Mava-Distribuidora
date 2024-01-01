from os import *
from tkinter import *
from tkinter import filedialog
from tkinter import font
import MplXml


class Janela():
    '''Crima uma nova janelas com os componentes padrões '''

    def __init__(self):

        self._root = Tk()  # Instancia Tk no atributo root
        self._root.attributes('-alpha', 0.9)  # Define transparência da Janela
        self._root.maxsize(width=630, height=160)
        self._root.minsize(width=630, height=160)
        self._root.title('9002 - Inclusão de Lotes no Arquivo XML')
        self._root.iconbitmap('./Lotes_XML/images/mava_img.ico')

        # Cria um frame e passa como toplevel o root
        self._frame1 = Frame(self._root, width='200')

        self._lbl_titulo = Label(self._root)
        self._lbl_titulo['text'] = 'Rotina de inclusão de Lote no XML'
        self._lbl_titulo['bg'] = 'black'
        self._lbl_titulo['font'] = ('verdana', '13', 'bold')
        self._lbl_titulo['fg'] = 'white'
        self._lbl_titulo.grid(row=0, columnspan=3, sticky=E+W, padx=5)

        self.lbl_info_caminho = Label(
            self._frame1, text='Insira o caminho do Arquivo ou clique em abrir', width='60')

        self._Ent_caminho = Entry(self._frame1, width='60')

        self.btn_abrir = Button(self._frame1, command=self.busca_arquivo)
        self.btn_abrir.configure(
            foreground='blue', text='Clique para Abrir o arquivo XML')

        ''' Colocando os elemetos na janela '''

        self._frame1.grid(row=1, column=0)

        self.lbl_info_caminho.grid(row=0, column=0, sticky=E+W)

        self._Ent_caminho.grid(row=1, column=0)

        self.btn_abrir.grid(row=1, column=2, sticky=E+W)

        ''' Fim da configuração dos elemos na janela '''

    def busca_arquivo(self):
        file = filedialog.askopenfilename()
        self.frame_arq_selecionado = Frame(self._root)
        self.lbl_selecioado = Label(
            self.frame_arq_selecionado)
        self.lbl_selecioado['text'] = ''
        self.lbl_selecioado['text'] = str(file)
        self.frame_arq_selecionado.grid(row=2, column=0, columnspan=3)
        self.lbl_selecioado.grid(row=0, column=0, columnspan=3)

        self.frame2 = Frame(self._root)
        self.btn_processa_xml = Button(
            self.frame2, text='Processar Arquivo', command=lambda: MplXml.incluirLoteXML(str(file)))
        self.frame2.grid(row=3, column=0, columnspan=3)
        self.btn_processa_xml.grid(row=0, column=0)

    def mainloop(self):
        self._root.mainloop()


if __name__ == '__main__':
    root = Janela()
    root.mainloop()
