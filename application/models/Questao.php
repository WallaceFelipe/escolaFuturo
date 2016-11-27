<?php

    class Questao extends CI_MODEL {
        public $idquestao;
        public $disciplina_codigo;
        public $enunciado;
        public $opcao1;
        public $opcao2;
        public $opcao3;
        public $opcao4;
        public $resposta;
 
        /*
            Construtor
        */

        public function __construct($idQuestao=0) {

            parent::__contruct();
            /* Carrega biblioteca do banco
            $this->load->database();

            if ($idQuestao) {

                
                $this->db->where('idquestao', $idQuestao);
                
                $result = $this->db->get('questao')->result()[0];
                
                $this->idquestao = $result->idquestao;
                $this->disciplina_codigo = $result->disciplina_codigo;
                $this->enunciado = $result->enunciado;
                $this->opcao1 = $result->opcao1;
                $this->opcao2 = $result->opcao2;
                $this->opcao3 = $result->opcao3;
                $this->opcao4 = $result->opcao4;
                $this->resposta = $result->resposta;
                
                
            } */

        }

        public function save () {

        }
        
    }