programa
{
	//Bibliotecas necessárias
	inclua biblioteca Sons
	inclua biblioteca Arquivos --> file
	inclua biblioteca Texto --> txt
	inclua biblioteca Util
	
	funcao inicio()
	{
		musica_fundo()
		carregar_quiz()
		menu_principal()
	}

	funcao musica_fundo()
	{
		//Carregar uma música suave de fundo, com volume em 30%
		cadeia arquivo_musica = "./bgmusic.mp3"
		inteiro bgmusica = Sons.carregar_som(arquivo_musica)
		Sons.definir_volume(60)
		Sons.reproduzir_som(bgmusica, verdadeiro)
	}

	funcao carregar_quiz()
	{
		cadeia arquivo_quiz = "./quiz.txt"
		inteiro quiz = file.abrir_arquivo(arquivo_quiz, file.MODO_LEITURA)
		//Teste para aplicação no projeto. Remover depois.
		/*
		para (inteiro cont = 0; cont < 11; cont++)
		{
			escreva(file.ler_linha(quiz))
			escreva("\n") 
		}
		 */

	}
	funcao menu_principal()
	{
		//Tela-título
		escreva("Olá, jogador(a), seja bem vindo ao:\n\n")
		
		escreva("████               █           ████        █\n")
		escreva("█   █            █████        █    █\n")
		escreva("█   █  ███   ███   █   █   █  █    █ █   █ █ █████\n")
		escreva("████  █   █ █      █   █   █  █  █ █ █   █ █   █\n")
		escreva("█     █   █ █      █   █   █  █   ██ █   █ █  █\n")
		escreva("█      ███  █      █    ███    ████   ███  █ █████")
		
		escreva("\n\nO seu game favorito de perguuntas e respostas!")

		escreva("\n\nMENU PRINCIPAL")
		escreva("\n--------------")
		escreva("\nEscolha uma opção para comecar: \n\n")
		escreva("1 - INICIAR JOGO\n")
		escreva("2 - ENCERRAR\n\n")

		caracter opcao1
		leia(opcao1)

		escolha (opcao1)
		{
			caso '1':
			//escreva("Aqui insiro o menu de opções. Bom trabalho.")
			menu_opcoes()
			pare

			caso '2':
			Util.aguarde(10)
		}
	}

	funcao menu_opcoes()
	{
		limpa()
		escreva("Selecione o tema das questões: ")
		escreva("\n------------------------------")
		escreva("\n\n")
		escreva("1 - Super Mario")
		escreva("\n2 - The Legend of Zelda\n\n")

		caracter opcao2
		logico escolha_menu = falso

		enquanto(escolha_menu == falso)
		{
			leia(opcao2)
			escolha (opcao2)
			{
				caso '1':
				//Aqui vem o jogo com as questões de Super Mario.
				escreva("Aqui vem o jogo com as questões de Super Mario. Boa sorte!")
				Util.aguarde(10000)
				pare
	
				caso '2':
				//Aqui vem o jogo com as questões de The Legend of Zelda.
				escreva("Aqui vem o jogo com as questões de The Legend of Zelda. Boa sorte!")
				Util.aguarde(10000)
				pare
	
				caso contrario:
				escreva("Por gentileza, escolha uma opção válida: ")
				escolha_menu = falso
			}
		}
		
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1506; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */