programa
{
	//Bibliotecas necessárias
	inclua biblioteca Sons
	inclua biblioteca Arquivos --> file
	inclua biblioteca Texto --> txt
	inclua biblioteca Util

	//Matrizes necessárias para o funcionamento do quiz
	cadeia matriz_1[5][7] //matriz do tema "Super Mario"
	cadeia matriz_2[5][7] //matriz do tema "The Legend of Zelda"
	
	funcao inicio()
	{
		//musica_fundo()
		//carregar_quiz()
		//menu_principal()
		quiz_matriz()
	}

	funcao quiz_matriz()
	{
		//Função para organizar o arquivo quiz.txt, carregado no programa via "carregar_quiz()",
		//em matrizes, conforme tema escolhido em menu_opcoes().

		inteiro quiz = carregar_quiz()
		//para (inteiro linha = 0; linha < 10; linha++)
		//{
		inteiro linha = 0
		cadeia linha_atual = "Qual personagem NÃO é um companheiro de aventura de Mario em seus jogos?|Super Mario|1|Zelda|Toad|Rosalina|Cappy"
		inteiro categoria = txt.posicao_texto("Super Mario", linha_atual, 0)
		
		se (categoria != -1)
		{
			para (inteiro coluna = 0; coluna < 7; coluna++)
			{
				//primeiro, pesquisa as ocorrências de "Super Mario" em cada linha, uma por cada linha
				//cadeia linha_atual = file.ler_linha(quiz)
				inteiro pipe = txt.posicao_texto("|", linha_atual, 0)
				se (pipe < txt.numero_caracteres(linha_atual) e pipe != -1)
				{
					matriz_1[linha][coluna] = txt.extrair_subtexto(linha_atual, 0, pipe)
					linha_atual = txt.extrair_subtexto(linha_atual, pipe + 1, txt.numero_caracteres(linha_atual)) 
				}
				senao se (pipe == -1)
				{
					matriz_1[linha][coluna] = linha_atual
				}
			}
		}
		//teste se a matriz está sendo escrita a primeira coluna. Provisório.
		para (inteiro coluna = 0; coluna < 7; coluna++)
		{
			escreva("valor em matriz_1[0][", coluna, "]: ", matriz_1[0][coluna], "\n")
		}
		
	}

	funcao musica_fundo()
	{
		//Carregar uma música suave de fundo, com volume em 30%
		cadeia arquivo_musica = "./bgmusic.mp3"
		inteiro bgmusica = Sons.carregar_som(arquivo_musica)
		Sons.definir_volume(60)
		Sons.reproduzir_som(bgmusica, verdadeiro)
	}

	funcao inteiro carregar_quiz()
	{
		cadeia arquivo_quiz = "./quiz.txt"
		inteiro quiz = file.abrir_arquivo(arquivo_quiz, file.MODO_LEITURA)
		retorne quiz
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
		//Menu para as opções de jogo: categoria e número de questões.
		limpa()
		escreva("Selecione o tema das questões: ")
		escreva("\n------------------------------")
		escreva("\n\n")
		escreva("1 - Super Mario")
		escreva("\n2 - The Legend of Zelda\n\n")

		caracter opcao1
		inteiro opcao2
		logico escolha_menu = falso

		enquanto(escolha_menu == falso)
		{
			leia(opcao1)
			escolha (opcao1)
			{
				caso '1':
				//Aqui vem o jogo com as questões de Super Mario.
				escreva("Aqui vem o jogo com as questões de SUPER MARIO. Boa sorte!")
				Util.aguarde(1000)
				escolha_menu = verdadeiro
				pare
	
				caso '2':
				//Aqui vem o jogo com as questões de The Legend of Zelda.
				escreva("Aqui vem o jogo com as questões de THE LEGEND OF ZELDA. Boa sorte!")
				Util.aguarde(1000)
				escolha_menu = verdadeiro
				pare
	
				caso contrario:
				escreva("Por gentileza, escolha uma opção válida: ")
				escolha_menu = falso
			}
		}
		
		//Escolha do número de questões
		limpa()
		escreva("Escolha o número de questões para responder: \n\n")
		escreva("---> ")
		leia(opcao2)

		carregando()
		//jogo_principal()
	}
	
	funcao carregando()
	{
		//botão bonitinho para simular carregamento
		para (inteiro cont=0; cont<20; cont++)
		{
			limpa()
			escreva("--")
			Util.aguarde(100)
			limpa()
			escreva("|")
			Util.aguarde(100)
			limpa()
			escreva("/")
			Util.aguarde(100)
			limpa()	
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 849; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */