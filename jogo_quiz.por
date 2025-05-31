programa
{
	//Bibliotecas necessárias
	inclua biblioteca Sons
	inclua biblioteca Arquivos --> file
	inclua biblioteca Texto --> txt
	inclua biblioteca Util
	
	//Matrizes necessárias para o funcionamento do quiz
	cadeia matriz_quiz[100][7] //Matriz geral

	//Vetor para armazenar as categorias - máximo de 10 categorias
	cadeia v_categoria[10]

	//variável para armazenar a escolha do TEMA
	cadeia tema = ""

	//variável para armazenar a escolha do Nº de questões
	inteiro qtde_questoes = 0
	
	funcao inicio()
	{
		musica_fundo()
		menu_principal()
		menu_opcoes()
	}

	funcao matriz_do_quiz()
	{
		inteiro quiz = carregar_quiz()
		
		para (inteiro linha = 0; linha < Util.numero_linhas(matriz_quiz); linha++)
		{
			cadeia linha_atual = file.ler_linha(quiz)

			para (inteiro coluna = 0; coluna < Util.numero_colunas(matriz_quiz); coluna++)
			{
				inteiro pipe = txt.posicao_texto("|", linha_atual, 0)
				se (pipe < txt.numero_caracteres(linha_atual) e pipe != -1)
				{
					matriz_quiz[linha][coluna] = txt.extrair_subtexto(linha_atual, 0, pipe)
					linha_atual = txt.extrair_subtexto(linha_atual, pipe + 1, txt.numero_caracteres(linha_atual)) 
				}
				senao se (pipe == -1)
				{
					matriz_quiz[linha][coluna] = linha_atual
				}
				//teste se a matriz está populada com os dados do arquivo. Provisório. Ignora linhas não existentes.
				//se (linha_atual != "")
				//escreva("valor em matriz_quiz[", linha, "][", coluna, "]: ", matriz_quiz[linha][coluna], "\n")
			}
		}
	}

	funcao categorias()
	{
		//Aqui iremos rastrear as categorias e trazê-las para o menu de opções e para 
		//o sorteio das perguntas
		matriz_do_quiz()
		//------------------------------------
		v_categoria[0] = matriz_quiz[0][1]
		inteiro cat = 1
		para (inteiro cont = 1; cont < Util.numero_linhas(matriz_quiz); cont++)
		{
			se (matriz_quiz[cont][1] != matriz_quiz[cont-1][1])
			{
				v_categoria[cat] = matriz_quiz[cont][1]
				cat++
			}
		}
		/*
		//Teste para saber se as categoria estão registrando certinho.
		para (inteiro cont=0; cont<10; cont++)
		{
			se (v_categoria[cont] != "")
				escreva("Valor em v_categoria[", cont, "]: ", v_categoria[cont], "\n")
		}
		*/
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
		
		escreva("\n\nO seu game favorito de perguntas e respostas!")

		/*
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
		*/
		Util.aguarde(2000)
		menu_opcoes()
		
	}

	funcao menu_opcoes()
	{
		//Menu para as opções de jogo: categoria e número de questões.
		//limpa()
		categorias() //inicia a função para popular v_categorias (vetor)

		escreva("\n\n\n")
		escreva("Selecione o tema das questões: ")
		escreva("\n------------------------------")
		escreva("\n\n")
		
		para (inteiro cont = 0; cont < Util.numero_elementos(v_categoria); cont++)
		{
			se (v_categoria[cont] != "")
				escreva(cont + 1, " - ", v_categoria[cont], ";", "\n")
		}

		inteiro opcao //leitura da escolha do jogador
		logico escolha_menu = falso //validação do laço de repetição, na ausência do switch... case.

		enquanto (escolha_menu == falso)
		{
			leia(opcao)
			se (opcao < 0 ou opcao > Util.numero_elementos(v_categoria))
				{
					escreva("Por favor, escolha uma opção do menu: ")
					escolha_menu = falso
				}
			senao
			{
				para (inteiro cont = 0; cont < Util.numero_elementos(v_categoria); cont++)
				{
					se (opcao == cont + 1 e v_categoria[cont] != "")
					{
						tema = v_categoria[cont]
						escolha_menu = verdadeiro
						escreva("Você escolheu a categoria ", tema, ". Boa sorte!")
						Util.aguarde(1200)
					}
					senao se (opcao == cont + 1 e tema == "")
					{
						escreva("Por favor, escolha uma opção do menu: ")
						escolha_menu = falso
					}
				}
			}
		}
		
		//Escolha do número de questões
		limpa()
		escreva("Escolha o número de questões para responder (min. 5, máx. 10): \n\n")
		escreva("---> ")
		leia(qtde_questoes)
		enquanto (qtde_questoes < 5 ou qtde_questoes > 10)
		{
			escreva("Por favor, escolha um número entre 5 e 10 questões: ")
			leia(qtde_questoes)
		}


		carregando(10)
		//jogo_principal()
	}
	
	funcao carregando(inteiro dot)
	{
		//botão bonitinho para simular carregamento
		escreva("Carregando.")
		para (inteiro cont=0; cont < dot; cont++)
		{
			escreva(".")
			Util.aguarde(500)	
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 3105; 
 * @DOBRAMENTO-CODIGO = [27, 54, 80, 89];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */