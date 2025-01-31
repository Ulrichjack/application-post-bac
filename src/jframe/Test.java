/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package jframe;

/**
 *
 * @author COMPUTER-STORE
 */

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import com.toedter.calendar.JDateChooser;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class Test extends javax.swing.JFrame {

    private JTextField domainesTextField;
    private JComboBox<String> diplomeComboBox;
    private JComboBox<String> bacComboBox;
    private JDateChooser debutDateChooser;
    private JTable resultsTable;
    private DefaultTableModel tableModel;

    private List<String> domainesSelectionnes;

    public Test() {
        initComponents();
        domainesSelectionnes = new ArrayList<>();
    }

    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        jPanel3 = new javax.swing.JPanel();
        jLabel2 = new javax.swing.JLabel();
        jPanel2 = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        jPanel4 = new javax.swing.JPanel();
        jLabel3 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        getContentPane().setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jPanel1.setBackground(new java.awt.Color(102, 102, 255));
        jPanel1.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jPanel3.setBackground(new java.awt.Color(255, 255, 255));
        jPanel3.setVerifyInputWhenFocusTarget(false);
        jPanel3.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());
        jPanel1.add(jPanel3, new org.netbeans.lib.awtextra.AbsoluteConstraints(520, 52, 440, 2));

        jLabel2.setFont(new java.awt.Font("Segoe UI Black", 1, 36)); // NOI18N
        jLabel2.setIcon(new javax.swing.ImageIcon(getClass().getResource("/icons/icons/22.png"))); // NOI18N
        jLabel2.setText("Recherche Formation ");
        jPanel1.add(jLabel2, new org.netbeans.lib.awtextra.AbsoluteConstraints(510, 0, 480, 60));

        jPanel2.setBackground(new java.awt.Color(255, 51, 51));
        jPanel2.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jPanel2MouseClicked(evt);
            }
        });

        jLabel1.setFont(new java.awt.Font("Verdana", 0, 18)); // NOI18N
        jLabel1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/AddNewBookIcons/AddNewBookIcons/icons8_Rewind_48px.png"))); // NOI18N
        jLabel1.setText("Back");
        jLabel1.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jLabel1MouseClicked(evt);
            }
        });

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 107, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(27, Short.MAX_VALUE))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 29, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jPanel1.add(jPanel2, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 0, 140, 40));

        jPanel4.setBackground(new java.awt.Color(102, 102, 255));

        jLabel3.setBackground(new java.awt.Color(255, 255, 255));
        jLabel3.setFont(new java.awt.Font("Verdana", 1, 36)); // NOI18N
        jLabel3.setText(" X");
        jLabel3.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jLabel3MouseClicked(evt);
            }
        });

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                .addGap(0, 31, Short.MAX_VALUE)
                .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 69, javax.swing.GroupLayout.PREFERRED_SIZE))
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 42, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 0, Short.MAX_VALUE))
        );

        jPanel1.add(jPanel4, new org.netbeans.lib.awtextra.AbsoluteConstraints(1390, 0, 100, 40));

        jLabel4.setText("Veillez remplir les cases suivantes");
        jPanel1.add(jLabel4, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 50, 180, 50));

        getContentPane().add(jPanel1, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 0, 1490, 110));

        // Panel for form components
        JPanel formPanel = new JPanel(new GridLayout(6, 2));
        formPanel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));

        formPanel.add(new JLabel("Domaines d'intérêt sélectionnés:"));
        domainesTextField = new JTextField();
        domainesTextField.setEditable(false);
        formPanel.add(domainesTextField);

        formPanel.add(new JLabel("Type de diplôme:"));
        diplomeComboBox = new JComboBox<>(new String[]{"Licence", "Master", "Doctorat", "Autre"});
        formPanel.add(diplomeComboBox);

        formPanel.add(new JLabel("Type de Bac:"));
        bacComboBox = new JComboBox<>(new String[]{"S", "ES", "L", "STMG", "Autre"});
        formPanel.add(bacComboBox);

        formPanel.add(new JLabel("Date de début de formation:"));
        debutDateChooser = new JDateChooser();
        formPanel.add(debutDateChooser);

        JButton searchButton = new JButton("Rechercher");
        formPanel.add(new JLabel());  // Empty cell for layout purposes
        formPanel.add(searchButton);

        getContentPane().add(formPanel, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 120, 600, 240));

        // Table to display search results
        tableModel = new DefaultTableModel(new String[]{"Nom", "Description", "Domaine", "Localisation", "Type Diplôme", "Durée", "Modalité", "Conditions"}, 0);
        resultsTable = new JTable(tableModel);
        getContentPane().add(new JScrollPane(resultsTable), new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 370, 1490, 480));

        setSize(new java.awt.Dimension(1503, 865));
        setLocationRelativeTo(null);

        // Action listeners
        domainesTextField.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                domainesTextFieldActionPerformed(evt);
            }
        });

        searchButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                searchButtonActionPerformed(evt);
            }
        });
    }

    private void jLabel1MouseClicked(java.awt.event.MouseEvent evt) {
        HomePage home = new HomePage();
        home.setVisible(true);
        dispose();
    }

    private void jPanel2MouseClicked(java.awt.event.MouseEvent evt) {
        HomePage home = new HomePage();
        home.setVisible(true);
        dispose();
    }

    private void jLabel3MouseClicked(java.awt.event.MouseEvent evt) {
        System.exit(0);
    }

    private void domainesTextFieldActionPerformed(java.awt.event.ActionEvent evt) {
        // TODO add your handling code here:
    }

    private void searchButtonActionPerformed(java.awt.event.ActionEvent evt) {
        String diplome = (String) diplomeComboBox.getSelectedItem();
        String bac = (String) bacComboBox.getSelectedItem();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String debutDate = dateFormat.format(debutDateChooser.getDate());

        // Connexion à la base de données et requête
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ma_base_de_donnees", "root", "");
             PreparedStatement pst = con.prepareStatement("SELECT * FROM formations WHERE domaine IN (?) AND type_diplome = ? AND serie_bac_requise = ? AND (YEAR(?)) >= YEAR(NOW())")) {

            String domainesStr = String.join(",", domainesSelectionnes);
            pst.setString(1, domainesStr);
            pst.setString(2, diplome);
            pst.setString(3, bac);
            pst.setString(4, debutDate);

            ResultSet rs = pst.executeQuery();

            // Vider le modèle de tableau avant de remplir avec de nouvelles données
            tableModel.setRowCount(0);

            while (rs.next()) {
                String nom = rs.getString("nom");
                String description = rs.getString("description");
                String localisation = rs.getString("localisation");
                int duree = rs.getInt("duree");
                String modalite = rs.getString("modalite");
                String conditions = rs.getString("conditions_admission");

                tableModel.addRow(new Object[]{nom, description, String.join(", ", domainesSelectionnes), localisation, diplome, duree, modalite, conditions});
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Erreur lors de la recherche : " + ex.getMessage(), "Erreur SQL", JOptionPane.ERROR_MESSAGE);
        }
    }

    public static void main(String args[]) {
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Recherche().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify                     
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    // End of variables declaration                   
}

