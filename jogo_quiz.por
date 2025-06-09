programa
{	
	//Querido Professor, por favor, nos dê uma boa nota; esse jogo deu um trabalhão para fazer!
	
	//Bibliotecas necessárias
	inclua biblioteca Sons
	inclua biblioteca Arquivos --> file
	inclua biblioteca Texto --> txt
	inclua biblioteca Util
	inclua biblioteca Tipos --> t

	// variável para armazenar o endereço do quiz
	inteiro quiz = 0
	
	//Matriz principal com todas as perguntas do quiz
	cadeia matriz_quiz[100][7]

	//Vetor para armazenar as categorias - máximo de 10 categorias
	cadeia v_categoria[10]

	//variável para armazenar a escolha do TEMA
	cadeia tema = ""

	//variável para armazenar a escolha do Nº de questões
	inteiro qtde_questoes = 0

 	//variáveis para armazenar intervalo para puxar da matriz principal
	inteiro quiz_inicio = 0, quiz_fim = 9	

	//vetor para armazenar as questoes sorteadas
	inteiro v_quiz[10] //10 é o maximo de questoes permitidas

	//Vetor para armazenar as respostas do jogador
	inteiro v_respostas[10]

	//Vetor para armazenar as alternativas corretas
	inteiro v_corretas[10]

	//Variáveis para armazenar a contagem de acertos e erros
	inteiro cont_acertos = 0, cont_erros = 0
	
	funcao inicio()
		{
			carregar_quiz()
			musica_fundo(70)
			menu_principal()
			jogo_quiz()
			gameover()
		}

	funcao matriz_do_quiz()
	{
		//Função para montar a matriz principal com todas as perguntas presentes no arquivo.
		//Máximo de 100 perguntas possíveis neste projeto.

		//Loop "escaneando" cada linha e cada coluna na estrutura dos dados.
		para (inteiro linha = 0; linha < Util.numero_linhas(matriz_quiz); linha++)
		{
			cadeia linha_atual = file.ler_linha(quiz)

			para (inteiro coluna = 0; coluna < Util.numero_colunas(matriz_quiz); coluna++)
			{
				inteiro pipe = txt.posicao_texto("|", linha_atual, 0)
				se (pipe < txt.numero_caracteres(linha_atual) e pipe != -1) //Se encontrou "|"
				{
					matriz_quiz[linha][coluna] = txt.extrair_subtexto(linha_atual, 0, pipe) //Subtrai a coluna
					linha_atual = txt.extrair_subtexto(linha_atual, pipe + 1, txt.numero_caracteres(linha_atual)) 
				}
				senao se (pipe == -1) //Se encorrou todos os "|"
				{
					matriz_quiz[linha][coluna] = linha_atual // Alternativa 4 (coluna 6)
				}
			}
		}
	}

	funcao categorias()
	{
		//Aqui, iremos rastrear as categorias e trazê-las para o menu de opções e para 
		//o sorteio das perguntas
		matriz_do_quiz()
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
	}
	
	funcao musica_fundo(inteiro vol)
	{
		//Carregar uma música suave de fundo, com volume customizável
		cadeia arquivo_musica = "./bgmusic.mp3"
		inteiro bgmusica = Sons.carregar_som(arquivo_musica)
		Sons.definir_volume(vol)
		Sons.reproduzir_som(bgmusica, verdadeiro)
	}

	funcao inteiro carregar_quiz()
	{
		//Função para puxar os dados do arquivo "quiz.txt"
		cadeia arquivo_quiz = "./quiz.txt"
		quiz = file.abrir_arquivo(arquivo_quiz, file.MODO_LEITURA)
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
		Util.aguarde(2000)
		menu_opcoes()
		
	}

	funcao menu_opcoes()
	{
		//Menu para as opções de jogo: categoria e número de questões.
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

		//leitura da escolha do jogador
		inteiro opcao 
		logico escolha_menu = falso //validação do laço de repetição, alternativo ao uso de switch... case.

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
				inteiro cont = 0
				enquanto (cont < Util.numero_elementos(v_categoria) e escolha_menu == falso)
				{
					se (opcao == cont + 1 e v_categoria[cont] != "")
					{
						tema = v_categoria[cont]
						escolha_menu = verdadeiro
						escreva("Você escolheu a categoria ", tema, ". Boa sorte!")
						define_categoria()
						Util.aguarde(1200)
					}
					senao se (opcao == cont + 1 e tema == "")
					{
						escreva("Por favor, escolha uma opção do menu: ")
						escolha_menu = falso
					}
					cont++
				}
			}
		}
		
		//Escolha do número de questões pelo jogador
		limpa()
		escreva("Escolha o número de questões para responder (min. 5, máx. 10): \n\n")
		escreva("---> ")
		leia(qtde_questoes)
		enquanto (qtde_questoes < 5 ou qtde_questoes > 10)
		{
			escreva("Por favor, escolha um número entre 5 e 10 questões: ")
			leia(qtde_questoes)
		}

		escreva("\n")
		carregando(10)
	}
	
	funcao carregando(inteiro dot)
	{
		//Função bonitinha para simular carregamento
		//Personalizável pelo parâmetro dot = pontos
		escreva("Carregando.")
		para (inteiro cont=0; cont < dot; cont++)
		{
			escreva(".")
			Util.aguarde(500)
		}
	}

	funcao define_categoria()
	{
		//Aqui atribuḿos o tema às questões (e seus respectivos índices na matriz),
		//para sortear as questões do do tema escolhido
		//logo em seguida. usamos as variáveis qtde_inicio e qtde_fim para
		//salvar o intervalo das questões da matriz principal.
		//Ex: v_categoria[0] = linhas 0 a 9
		//    v_categoria[1] = linhas 10 a 19

		para (inteiro cont = 0; cont < Util.numero_elementos(v_categoria); cont++)
		{
			se (tema == v_categoria[cont])
			{
				quiz_inicio = cont * 10
				quiz_fim = quiz_inicio + 9
			}
		}
	}

	funcao sorteia_perguntas()
	{
		//Função para sortear as perguntas armazenadas em vetor, evitando repetição,
		//e armazenar em vetor próprio, para exibição logo em seguida.
		
		inteiro cont = 0
		enquanto (cont < qtde_questoes) //Populando o vetor
		{
			inteiro sorteado = Util.sorteia(quiz_inicio, quiz_fim)
			logico repete = falso //Verifica se há repetição da pergunta sorteada
			para (inteiro v_cont = 0; v_cont < cont; v_cont++)
			{
				se (v_quiz[v_cont] == sorteado)
				{
					repete = verdadeiro //Opa, repetiu!
				}
			}
			se (repete == falso) //Eba, não repetiu!!
			{
				v_quiz[cont] = sorteado //registra o sorteio no vetor
				cont++ //sobe o incremento para o próxmo índice
			}
		}
	}

	funcao jogo_quiz()
	{
		//Mostrar o quiz para o jogador. Questões mostradas conforme
		//sorteadas e armazenadas em vetor.
		limpa()
		sorteia_perguntas()
		//laço de repetição para mostrar as perguntas uma a uma
		para (inteiro cont = 0; cont < qtde_questoes; cont++)
		{
			//desvio condicional para armazenar os acertos e os erros
			v_respostas[cont] = pergunta(v_quiz[cont], cont)
			se (v_respostas[cont] == v_corretas[cont])
				cont_acertos++
			senao
				cont_erros++
		}
	}
	
	funcao inteiro pergunta(inteiro q, inteiro c)
	//Função para a montagem da pergunta na tela
	//Parâmetros: q = questão; c = contagem; r = resposta
	{
		//Exbindo a pergunta na tela
		limpa()
		escreva("PERGUNTA ", c + 1, ":\n")
		escreva(matriz_quiz[q][0])
		escreva("\n\n")
		escreva("1) ", matriz_quiz[q][3], "\n")
		escreva("2) ", matriz_quiz[q][4], "\n")
		escreva("3) ", matriz_quiz[q][5], "\n")
		escreva("4) ", matriz_quiz[q][6], "\n")
		//solicitando resposta do jogador
		escreva("\nInforme a resposta ---> ")
		//Armazenar resposta correta da referida questão (e converter de cadeia para inteiro)
		v_corretas[c] = Tipos.cadeia_para_inteiro(matriz_quiz[q][2], 10)
		//Armazenar resposta do jogador
		inteiro r
		leia(r)
		retorne r
	}
	
	funcao gameover()
	{
		//Objetivo, mostrar o resultado para o jogador.
		//exibir opção para voltar ao menu principal.
		limpa()
		carregando(15)
		limpa()
		para (inteiro cont = 0; cont < qtde_questoes; cont++)
		{
			//função para montar a pergunta
			gabarito(v_quiz[cont],cont)
		}
		contagem_acertos()
		contagem_erros()

		// Game over!
		escreva("\nGAME OVER!")
		escreva("\nObrigada por jogar o portuQuiz. Até a próxima! :)")

		cadeia sair
		escreva("\n\nPressione ENTER para encerrar.")
		leia(sair)
	}

	funcao gabarito(inteiro q, inteiro c)
	{
		//Exbindo a pergunta original na tela
		escreva("PERGUNTA ", c + 1, ":\n")
		escreva(matriz_quiz[q][0])
		escreva("\n\n")
		escreva("1) ", matriz_quiz[q][3], "\n")
		escreva("2) ", matriz_quiz[q][4], "\n")
		escreva("3) ", matriz_quiz[q][5], "\n")
		escreva("4) ", matriz_quiz[q][6], "\n")
		//Exibir a resposta dada pelo jogador
		escreva("\nRESPOSTA DADA PELO JOGADOR ---> ", v_respostas[c])
		escreva("\nRESPOSTA CORRETA ---> ", v_corretas[c])
		escreva("\n\n--------------------------------------------\n")
	}

	funcao contagem_acertos()
	{
		escreva("Quantidade de acertos do jogador: ")
		escreva(cont_acertos)
		escreva("\n")
	}
	funcao contagem_erros()
	{
		escreva("Quantidade de erros do jogador: ")
		escreva(cont_erros)
		escreva("\n")
	}
	//portuQuiz. Todos os direitos reservados.
	//Feito por Maxine e Larissa, com orientação do Prof. Flavio Viotti.
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 273; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */