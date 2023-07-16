describe('Product Details Page', () => {
  beforeEach(() => {
    cy.visit('/');
    cy.get('.products').first().find('a').click();
  });

  it('Displays the product details', () => {
    cy.get('.product-detail').should('be.visible');
  cy.get('.product-detail h1').should('contain', 'Product Name');
  });
});