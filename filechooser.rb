#!/usr/local/bin/jruby

# ZetCode JRuby Swing tutorial
# 
# In this program, we use a JFileChooser
# to load a c file.
# 
# author: Jan Bodnar
# website: www.zetcode.com
# last modified: December 2010


include Java
import java.awt.BorderLayout
import java.awt.Color
import javax.swing.JFrame
import javax.swing.JButton
import javax.swing.JPanel
import javax.swing.JToolBar
import javax.swing.JFileChooser
import javax.swing.JTextArea
import javax.swing.JTextPane
import javax.swing.JScrollPane
import javax.swing.BorderFactory
import javax.swing.filechooser::FileNameExtensionFilter

class Example < JFrame
  
    def initialize
        super "FileChooser"
        
        self.initUI
    end
      
    def initUI
      
        @panel = JPanel.new
        @panel.setLayout BorderLayout.new

        toolbar = JToolBar.new
        openb = JButton.new "Choose file"
        openb.addActionListener do |e|
            chooseFile = JFileChooser.new
            filter = FileNameExtensionFilter.new "c files", "c"
            chooseFile.addChoosableFileFilter filter

            ret = chooseFile.showDialog @panel, "Choose file"

            if ret == JFileChooser::APPROVE_OPTION
                file = chooseFile.getSelectedFile
                text = self.readFile file
                @area.setText text.to_s     
            end
        end

        toolbar.add openb

        @area = JTextArea.new
        @area.setBorder BorderFactory.createEmptyBorder 10, 10, 10, 10

        pane = JScrollPane.new
        pane.getViewport.add @area

        @panel.setBorder BorderFactory.createEmptyBorder 10, 10, 10, 10
        @panel.add pane
        self.add @panel

        self.add toolbar, BorderLayout::NORTH
        
        self.setDefaultCloseOperation JFrame::EXIT_ON_CLOSE
        self.setSize 450, 400
        self.setLocationRelativeTo nil
        self.setVisible true
    end
    
    def readFile file
        
        filename = file.getCanonicalPath
        f = File.open filename, "r"
        text = IO.readlines filename
        return text
    end    
end

Example.new


