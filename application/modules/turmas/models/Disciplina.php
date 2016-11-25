<?php

class Disciplina extends CI_Model {
    public $iddisciplina;
    public $codigo;
    public $nome;

    /*
        Construtor
    */
    public function __construct ($iddisciplina=0) {
        // Carregando biblioteca do banco de dados
        $this->load->database();

        /*
            Recupera uma disciplina já existente do banco de dados
                @ se $iddisciplina for passado como parâmetro
        */
        if ($iddisciplina) {
            // Obtém a disciplina com respectivo "$iddisciplina"
            $this->db->where('iddisciplina', $iddisciplina);
            
            // Obtém o primeiro resultado (index 0) da busca
            $result = $this->db->get('disciplinas')->result()[0];

            // Monta o objeto disciplina
            $this->iddisciplina = $result->iddisciplina;
            $this->codigo = $result->codigo;
            $this->nome = $result->nome;
        }

        /*
            Adicionar nova disciplina
                @ se $iddisciplina não for passado como parâmetro
        */
        else {
            // Remove o atributo iddisciplina, já que ele será
            //  automaticamente gerado pelo banco de dados.
            unset( $this->iddisciplina );
        }
    }

    /*
        Adiciona ou atualiza a disciplina no banco de dados
    */
    public function save () {
        // Atualiza
        //  @ verifico se o atributo "iddisciplina" existe neste objeto.
        //    lembrando que este atributo é apagado se criamos uma nova disciplina.
        if ( isset($this->iddisciplina) ) {
             $this->db->update('disciplinas', $this, array('iddisciplina' => $this->iddisciplina));
        }
        // Salva
        else {
            $this->db->insert('disciplinas', $this);
        }
    }

    /*
        Deleta a disciplina do banco de dados
    */
    public function delete () {
        $this->db->delete('disciplinas', array('iddisciplina' => $this->iddisciplina));
    }

    /*
        Obtém uma lista de todas as disciplinas
    */
    public static function getDisciplinas () {
        // Obtém instância do CodeIgniter
        $CI =& get_instance();

        // Carregando biblioteca do banco de dados
        $CI->load->database();

        // Obtém todos os posts
        $CI->db->order_by("iddisciplina", "cresc");
        $result = $CI->db->get('disciplinas')->result();

        // Monta vetor de objetos "Disciplina"
        $disciplinas  = [];

        foreach ($result as $disciplina) {
            $tmp    = new Disciplina();
            $tmp->iddisciplina = $disciplina->iddisciplina;
            $tmp->codigo = $disciplina->codigo;
            $tmp->nome = $disciplina->nome;

            $disciplinas[] = $tmp;
        }

        return $disciplinas;
    }

}