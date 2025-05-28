programa
{
	//Bibliotecas necessárias
	inclua biblioteca Sons
	inclua biblioteca Arquivos --> file
	inclua biblioteca Texto --> txt
	inclua biblioteca Util
	
	funcao inicio()
	{
		carregar_quiz()
	}

	funcao musica_fundo()
	{
		//Carregar uma música suave de fundo, com volume em 30%
		cadeia arquivo_musica = "./bgmusic.mp3"
		inteiro bgmusica = Sons.carregar_som(arquivo_musica)
		Sons.definir_volume(30)
		Sons.reproduzir_som(bgmusica, verdadeiro)
	}

	funcao carregar_quiz()
	{
		cadeia arquivo_quiz = "./quiz.txt"
		inteiro quiz = file.abrir_arquivo(arquivo_quiz, file.MODO_LEITURA)
		para (inteiro cont = 0; cont < 11; cont++)
		{
			escreva(file.ler_linha(quiz))
			escreva("\n")
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 690; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */